
function drawVisualization(visual_div) {
    var url = visual_div.attr('data-url');
    var width = visual_div.attr('data-width') || 1024;
    var height = visual_div.attr('data-height') || 400;
    $.ajax(
            {
                url: url,
                dataType: "json",
                async: false,
                error: function (xhr, status, thrown) {
                    console.log("error me" + xhr + "; status=" + status + "; throw" + thrown);
                },
                success: function (jsonData, status, xhr) {
                    jsonData = [ jsonData, true ];

                    dataTable = google.visualization.arrayToDataTable.apply(null, jsonData);
                    debugger;
                    var options = { width: width, height: height};


                    var chart = new google.visualization.CandlestickChart(visual_div[0]);
                    chart.draw(dataTable, options);
                }
            });


}
