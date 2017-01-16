// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/


  $(document).ready(function() {
    $('table').DataTable();

    $('input.datetime_picker').datetimepicker({
      format: 'DD/MM/YYYY HH:mm',
      collapse: false,
      toolbarPlacement: 'top',
      showTodayButton: true,
      showClear: true
    });

    $('input[name="task[tags][]"]:last-of-type').focus();
    $('.add-tag-button').on('click', function(event) {
      var $lastTagField;
      event.preventDefault();
      $lastTagField = $('input[name="task[tags][]"]:last-of-type').clone();
      $lastTagField.val("");
      $(".task_tags").append($lastTagField);
      $lastTagField.focus();
    });


  });
