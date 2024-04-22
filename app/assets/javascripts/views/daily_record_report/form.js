$(function(){
  "use strict"

  $('#editable-document').on('click', function(e){
    e.preventDefault();
    $('#daily-record-report-form').attr('action', Routes.daily_record_report_editable_report_pt_br_path());
    $('#daily-record-report-form').submit();
  });

  $('#readonly-document').on('click', function(e){
    e.preventDefault();
    $('#daily-record-report-form').attr('action', Routes.daily_record_report_readonly_report_pt_br_path());
    $('#daily-record-report-form').submit();
  });
});
