
function total_per_month(cost_col,total_col) {
  var row_cost = 0;
    $('tr').each(function () {
        var cost = $(this).find(cost_col).text();
        if (!isNaN(cost) && cost.length !== 0) {
            cost = parseFloat(cost);
            // console.log(cost)
        }
        var freq = $(this).find('.frequency').text();
        console.log("freq: " + freq);
        switch(true) {
          case (freq.indexOf("Monthly") !=-1):
              freq = 1;
              break;
          case (freq.indexOf("Yearly") !=-1):
              freq = 1/12;
              break;
          case (freq.indexOf("Daily") !=-1):
              freq = 30;
              break;
          case (freq.indexOf("Weekly") !=-1):
              freq = 4;
              break;
          case (freq.indexOf("One Time Payment") !=-1):
              freq = 1;
              break;
          default:
              freq = 1;
        }
        console.log("freq: " + freq);
        row_cost = row_cost + (cost*freq);
    });
return $(total_col).text(row_cost.toFixed(2));
}

total_per_month('.fin_cost', '.fin_total');
total_per_month('.time_cost', '.time_total');
