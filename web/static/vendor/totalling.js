
function total_per_month(cost_col,total_col) {
  var row_cost = 0
    $('tr').each(function () {
        var cost = $(this).find(cost_col).text();
        if (!isNaN(cost) && cost.length !== 0) {
            cost = parseFloat(cost);
            // console.log(cost)
        };
        var freq = $(this).find('.frequency').text();
        switch(freq) {
          case "Monthly":
              freq = 1;
              break;
          case "Yearly":
              freq = 1/12;
              break;
          case "Daily":
              freq = 30;
              break;
          case "Weekly":
              freq = 4;
              break;
          case "One Time Payment":
              freq = 1;
              break;
          default:
              freq = 1;
        };
        // console.log(freq)
        row_cost = row_cost + (cost*freq);
    });
return $(total_col).text(row_cost.toFixed(2));
}

total_per_month('.fin_cost', '.fin_total');
total_per_month('.time_cost', '.time_total');
