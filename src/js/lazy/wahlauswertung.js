// wahlauswertung.js

class WahlauswertungCharts {
    constructor() {
        this.data = {};
        this.colors = d3.scaleOrdinal(d3.schemeCategory10);
        this.tooltip = d3.select("body").append("div")
            .attr("class", "tooltip");

        this.margin = { top: 20, right: 80, bottom: 60, left: 80 };
        this.width = 800 - this.margin.left - this.margin.right;
        this.height = 400 - this.margin.top - this.margin.bottom;

        // Pfad zu den Test-Dateien
        this.basePath = '/Users/thomashoffmann/Documents/Projects/php/tualo/papervote/tests/';
    }

    async init() {
        try {
            // http://localhost/server/ds/wahlbeteiligung_bericht_formel/read
            // Laden der JSON-Dateien aus dem tests-Verzeichnis
            const [abgabetypResponse, berichtConfigResponse, berichtAbgabetypConfigResponse, beteiligungResponse] = await Promise.all([
                /*d3.json(this.basePath + 'abgabetyp.json'),
                d3.json(this.basePath + 'bericht-config.json'),
                d3.json(this.basePath + 'bericht-abgabetyp-config.json'),
                d3.json(this.basePath + 'beteiligung.json')
                http://localhost/server/papervote/involvement/reporting
                */
                d3.json('../../../ds/abgabetyp/read'),
                d3.json('../../../ds/wahlbeteiligung_bericht/read'),
                d3.json('../../../ds/wahlbeteiligung_bericht_abgabetyp/read'),
                d3.json('../../../papervote/involvement/reporting?typ=1')
            ]);

            // Extrahiere Daten aus API-Response-Format
            this.data = {
                abgabetyp: abgabetypResponse.success ? abgabetypResponse.data.filter(d => d.id !== 0) : [],
                berichtConfig: berichtConfigResponse.success ? berichtConfigResponse.data : [],
                berichtAbgabetypConfig: berichtAbgabetypConfigResponse.success ? berichtAbgabetypConfigResponse.data : [],
                beteiligung: beteiligungResponse.success ? beteiligungResponse.data : beteiligungResponse
            };

            console.log('Geladene Daten:', this.data);
            this.createCharts();
            d3.select('.loading').style('display', 'none');

        } catch (error) {
            console.error('Fehler beim Laden der Daten:', error);
            d3.select('.loading').text(`Fehler beim Laden der Daten: ${error.message}`);
        }
    }

    createCharts() {
        const container = d3.select('#charts');
        container.selectAll('*').remove(); // Lösche vorherige Charts

        // Sortiere Berichte nach Reihenfolge
        const sortedBerichte = this.data.berichtConfig.sort((a, b) => (a.order || a.id) - (b.order || b.id));

        // Erstelle Charts für jeden Bericht
        sortedBerichte.forEach((bericht, index) => {
            const chartContainer = container.append('div')
                .attr('class', 'chart-container')
                .attr('id', `chart-${bericht.id}`);

            // Chart-Titel
            chartContainer.append('div')
                .attr('class', 'chart-title')
                .text(bericht.name || `Auswertung ${bericht.id}`);

            // Hauptchart für Grunddaten
            const mainData = this.extractMainData(bericht);
            if (mainData.length > 0) {
                this.createBarChart(chartContainer, mainData, `${bericht.name} - Übersicht`);
            }

            // Erweiterte Charts für Abgabetypen (falls konfiguriert)
            const abgabetypConfig = this.data.berichtAbgabetypConfig.find(c => c.bericht_id === bericht.id);
            if (abgabetypConfig) {
                const extendedData = this.extractExtendedData(bericht.id);
                if (extendedData.length > 0) {
                    this.createStackedBarChart(chartContainer, extendedData, `${bericht.name} - Nach Abgabetyp`);
                    this.createPieChart(chartContainer, extendedData, `${bericht.name} - Verteilung`);
                }
            }
        });

        // Falls keine Berichte konfiguriert sind, zeige alle verfügbaren Daten
        if (this.data.berichtConfig.length === 0) {
            this.createOverviewCharts(container);
        }
    }

    extractMainData(bericht) {
        const results = [];
        const fieldName = `wb_0${bericht.id}`;

        // Suche in beteiligung.json nach dem entsprechenden Feld
        if (this.data.beteiligung && this.data.beteiligung[fieldName] !== undefined) {
            results.push({
                category: bericht.name || `Bericht ${bericht.id}`,
                value: this.data.beteiligung[fieldName],
                label: bericht.name,
                bericht_id: bericht.id
            });
        }

        return results;
    }

    extractExtendedData(berichtId) {
        const results = [];

        this.data.abgabetyp.forEach(abgabetyp => {
            const fieldName = `wb_${berichtId}_${abgabetyp.id}`;

            if (this.data.beteiligung && this.data.beteiligung[fieldName] !== undefined) {
                results.push({
                    category: abgabetyp.name,
                    value: this.data.beteiligung[fieldName],
                    abgabetyp_id: abgabetyp.id,
                    abgabetyp_name: abgabetyp.name,
                    bericht_id: berichtId
                });
            }
        });

        return results;
    }

    createOverviewCharts(container) {
        // Erstelle Übersichtschart falls keine spezifische Konfiguration vorhanden ist
        const overviewData = [];

        // Sammle alle wb_* Felder aus beteiligung
        Object.keys(this.data.beteiligung).forEach(key => {
            if (key.startsWith('wb_')) {
                overviewData.push({
                    category: key,
                    value: this.data.beteiligung[key],
                    label: key
                });
            }
        });

        if (overviewData.length > 0) {
            const chartContainer = container.append('div')
                .attr('class', 'chart-container');

            chartContainer.append('div')
                .attr('class', 'chart-title')
                .text('Übersicht aller Wahlergebnisse');

            this.createBarChart(chartContainer, overviewData, 'Übersicht');
        }
    }

    createBarChart(container, data, title) {
        const svg = container.append('svg')
            .attr('width', this.width + this.margin.left + this.margin.right)
            .attr('height', this.height + this.margin.top + this.margin.bottom);

        const g = svg.append('g')
            .attr('transform', `translate(${this.margin.left},${this.margin.top})`);

        // Scales
        const xScale = d3.scaleBand()
            .domain(data.map(d => d.category))
            .range([0, this.width])
            .padding(0.1);

        const yScale = d3.scaleLinear()
            .domain([0, d3.max(data, d => d.value)])
            .nice()
            .range([this.height, 0]);

        // Axes
        g.append('g')
            .attr('class', 'axis')
            .attr('transform', `translate(0,${this.height})`)
            .call(d3.axisBottom(xScale))
            .selectAll('text')
            .style('text-anchor', 'end')
            .attr('dx', '-.8em')
            .attr('dy', '.15em')
            .attr('transform', 'rotate(-45)');

        g.append('g')
            .attr('class', 'axis')
            .call(d3.axisLeft(yScale));

        // Balken mit Animation
        g.selectAll('.bar')
            .data(data)
            .enter().append('rect')
            .attr('class', 'bar')
            .attr('x', d => xScale(d.category))
            .attr('width', xScale.bandwidth())
            .attr('y', this.height)
            .attr('height', 0)
            .attr('fill', (d, i) => this.colors(i))
            .transition()
            .duration(800)
            .delay((d, i) => i * 100)
            .attr('y', d => yScale(d.value))
            .attr('height', d => this.height - yScale(d.value));

        // Event Listeners nach Animation
        setTimeout(() => {
            g.selectAll('.bar')
                .on('mouseover', (event, d) => {
                    d3.select(event.currentTarget)
                        .transition()
                        .duration(200)
                        .attr('opacity', 0.7);
                    this.showTooltip(event, d);
                })
                .on('mouseout', (event, d) => {
                    d3.select(event.currentTarget)
                        .transition()
                        .duration(200)
                        .attr('opacity', 1);
                    this.hideTooltip();
                });
        }, 1000);

        // Werte auf Balken anzeigen
        g.selectAll('.value-label')
            .data(data)
            .enter().append('text')
            .attr('class', 'value-label')
            .attr('x', d => xScale(d.category) + xScale.bandwidth() / 2)
            .attr('y', d => yScale(d.value) - 5)
            .attr('text-anchor', 'middle')
            .style('font-size', '12px')
            .style('font-weight', 'bold')
            .style('fill', '#333')
            .style('opacity', 0)
            .text(d => d.value.toLocaleString('de-DE'))
            .transition()
            .duration(800)
            .delay((d, i) => i * 100 + 400)
            .style('opacity', 1);
    }

    createStackedBarChart(container, data, title) {
        if (!data.length) return;

        const svg = container.append('svg')
            .attr('width', this.width + this.margin.left + this.margin.right)
            .attr('height', this.height + this.margin.top + this.margin.bottom);

        const g = svg.append('g')
            .attr('transform', `translate(${this.margin.left},${this.margin.top})`);

        // Gruppiere Daten nach Abgabetyp
        const maxValue = d3.max(data, d => d.value);
        const totalValue = d3.sum(data, d => d.value);

        // Scales
        const xScale = d3.scaleBand()
            .domain(['Abgabetypen'])
            .range([0, this.width])
            .padding(0.3);

        const yScale = d3.scaleLinear()
            .domain([0, totalValue])
            .nice()
            .range([this.height, 0]);

        // Axes
        g.append('g')
            .attr('class', 'axis')
            .attr('transform', `translate(0,${this.height})`)
            .call(d3.axisBottom(xScale));

        g.append('g')
            .attr('class', 'axis')
            .call(d3.axisLeft(yScale));

        // Stacked Bars
        let yPos = 0;
        data.forEach((d, i) => {
            g.append('rect')
                .attr('class', 'stack-bar')
                .attr('x', xScale('Abgabetypen'))
                .attr('width', xScale.bandwidth())
                .attr('y', yScale(yPos + d.value))
                .attr('height', yScale(yPos) - yScale(yPos + d.value))
                .attr('fill', this.colors(d.abgabetyp_id))
                .on('mouseover', (event) => {
                    this.showTooltip(event, {
                        category: d.abgabetyp_name,
                        value: d.value,
                        percentage: ((d.value / totalValue) * 100).toFixed(1) + '%'
                    });
                })
                .on('mouseout', () => {
                    this.hideTooltip();
                });

            yPos += d.value;
        });

        // Legende
        this.createLegend(svg, data);
    }

    createPieChart(container, data, title) {
        const radius = Math.min(this.width, this.height) / 2 - 60;

        const svg = container.append('svg')
            .attr('width', this.width + this.margin.left + this.margin.right)
            .attr('height', this.height + this.margin.top + this.margin.bottom);

        const g = svg.append('g')
            .attr('transform', `translate(${(this.width + this.margin.left + this.margin.right) / 2},${(this.height + this.margin.top + this.margin.bottom) / 2})`);

        const pie = d3.pie()
            .value(d => d.value)
            .sort(null);

        const arc = d3.arc()
            .innerRadius(radius * 0.3) // Donut-Style
            .outerRadius(radius);

        const outerArc = d3.arc()
            .innerRadius(radius * 1.1)
            .outerRadius(radius * 1.1);

        const arcs = g.selectAll('.arc')
            .data(pie(data))
            .enter().append('g')
            .attr('class', 'arc');

        // Pie Slices mit Animation
        arcs.append('path')
            .attr('d', arc)
            .attr('fill', d => this.colors(d.data.abgabetyp_id))
            .attr('stroke', 'white')
            .attr('stroke-width', 2)
            .style('opacity', 0)
            .transition()
            .duration(800)
            .delay((d, i) => i * 100)
            .style('opacity', 1)
            .attrTween('d', function (d) {
                const interpolate = d3.interpolate({ startAngle: 0, endAngle: 0 }, d);
                return function (t) {
                    return arc(interpolate(t));
                };
            });

        // Event Listeners nach Animation
        setTimeout(() => {
            arcs.selectAll('path')
                .on('mouseover', (event, d) => {
                    d3.select(event.currentTarget)
                        .transition()
                        .duration(200)
                        .attr('transform', 'scale(1.05)');

                    const total = d3.sum(data, dd => dd.value);
                    this.showTooltip(event, {
                        category: d.data.abgabetyp_name,
                        value: d.data.value,
                        percentage: ((d.data.value / total) * 100).toFixed(1) + '%'
                    });
                })
                .on('mouseout', (event, d) => {
                    d3.select(event.currentTarget)
                        .transition()
                        .duration(200)
                        .attr('transform', 'scale(1)');
                    this.hideTooltip();
                });
        }, 1000);

        // Labels
        arcs.append('text')
            .attr('transform', d => `translate(${arc.centroid(d)})`)
            .attr('text-anchor', 'middle')
            .style('font-size', '12px')
            .style('font-weight', 'bold')
            .style('fill', 'white')
            .style('opacity', 0)
            .text(d => d.data.value.toLocaleString('de-DE'))
            .transition()
            .duration(800)
            .delay((d, i) => i * 100 + 400)
            .style('opacity', 1);
    }

    createLegend(svg, data) {
        const legend = svg.append('g')
            .attr('class', 'legend')
            .attr('transform', `translate(${this.width + this.margin.left + 20}, 50)`);

        const legendItems = legend.selectAll('.legend-item')
            .data(data)
            .enter().append('g')
            .attr('class', 'legend-item')
            .attr('transform', (d, i) => `translate(0, ${i * 25})`);

        legendItems.append('rect')
            .attr('width', 18)
            .attr('height', 18)
            .attr('fill', d => this.colors(d.abgabetyp_id))
            .attr('rx', 2);

        legendItems.append('text')
            .attr('x', 25)
            .attr('y', 14)
            .style('font-size', '12px')
            .style('fill', '#333')
            .text(d => `${d.abgabetyp_name} (${d.value.toLocaleString('de-DE')})`);
    }

    showTooltip(event, d) {
        this.tooltip.transition()
            .duration(200)
            .style('opacity', 0.9);

        this.tooltip.html(`
            <strong>${d.category}</strong><br/>
            <span style="color: #666;">Anzahl:</span> ${d.value.toLocaleString('de-DE')}<br/>
            ${d.percentage ? `<span style="color: #666;">Anteil:</span> ${d.percentage}` : ''}
        `)
            .style('left', (event.pageX + 10) + 'px')
            .style('top', (event.pageY - 28) + 'px');
    }

    hideTooltip() {
        this.tooltip.transition()
            .duration(300)
            .style('opacity', 0);
    }
}

// Initialisierung
document.addEventListener('DOMContentLoaded', function () {
    const charts = new WahlauswertungCharts();
    charts.init();
});