d3.json("/assets/list-dates.json").then(function(data) {
    // Initialize an empty object to store cumulative counts
    const cumulativeCounts = {};

    // Initialize an array to store cumulative data points
    const cumulativeData = [];

    // Iterate through each entry in the data
    data.forEach(function(entry) {
        // Iterate through each artist in the entry
        entry.artists.forEach(function(artist) {
            // Increment the cumulative count for the artist
            cumulativeCounts[artist] = (cumulativeCounts[artist] || 0) + 1;

            // Calculate the grand total of all artists up to this date
            const grandTotal = d3.sum(Object.values(cumulativeCounts));

            // Create a cumulative data point for the date
            const cumulativePoint = {
                date: new Date(entry.date),
                count: grandTotal  // Grand total up to this date
            };

            // Add the cumulative data point to the array
            cumulativeData.push(cumulativePoint);
        });
    });

    // Sort cumulative data by date
    cumulativeData.sort((a, b) => d3.ascending(a.date, b.date));

    // Define chart dimensions and margins
    const margin = { top: 20, right: 30, bottom: 30, left: 60 };
    const width = 500 - margin.left - margin.right;
    const height = 200 - margin.top - margin.bottom;

    // Create SVG element
    const svg = d3.select("#chart")
        .append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
        .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    // Define festivals
    const festivals = ["1995-05-28", "1995-08-22", "1995-12-09",
    "1996-05-25", "1996-12-04",
    "1997-05-24", "1997-05-25",
    "1998-07-18", "1998-12-19"
    ];
    const parseDate = d3.timeParse("%Y-%m-%d");
    festivalDates = festivals.map(d => parseDate(d));


    // Define scales for x and y axes
    const x = d3.scaleTime()
    .domain(d3.extent(cumulativeData, d => d.date))
        .range([0, width]);

    const y = d3.scaleLinear()
        .domain([0, d3.max(cumulativeData, d => d.count)])
        .nice()
        .range([height, 0]);

    // Define line generator
    const line = d3.line()
        .x(d => x(d.date))
        .y(d => y(d.count));

    // Append festival marks
    festivalDates.forEach(date => {
    svg.append('line')
       .attr('x1', x(date))
       .attr('x2', x(date))
       .attr('y0', 0)
       .attr('y1', height)
       .attr('stroke', "lightblue")
       .attr('opacity', 0.5);
    });

    // Append line to SVG
    svg.append("path")
        .datum(cumulativeData)
        .attr("fill", "none")
        .attr("stroke", "steelblue")
        .attr("stroke-width", 2)
        .attr("d", line);

    // Append x axis
    svg.append("g")
        .attr("transform", "translate(0," + height + ")")
        .call(d3.axisBottom(x)
            .ticks(d3.timeYear.every(2))
            .tickFormat(d3.timeFormat("%Y"))
        )
        .selectAll("text")
        .style("text-anchor", "start");

    // Append y axis
    svg.append("g")
        .call(d3.axisLeft(y));

});
