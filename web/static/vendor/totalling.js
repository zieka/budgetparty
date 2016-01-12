
  var fin_total = 0;
  var time_total = 0;

  $(".fin_cost").each(function() {
    var val = $.trim( $(this).text() );

    if ( val ) {
      val = parseFloat( val.replace( /^\$/, "" ) );
      fin_total += !isNaN( val ) ? val : 0;
    }
  });

  $(".time_cost").each(function() {
    var val = $.trim( $(this).text() );
    if ( val ) {
      val = parseFloat( val.replace( /^\$/, "" ) );
      time_total += !isNaN( val ) ? val : 0;
    }
  });

  $(".fin_total").text(fin_total);
  $(".time_total").text(time_total);
