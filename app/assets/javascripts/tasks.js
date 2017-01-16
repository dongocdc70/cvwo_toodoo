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
      showClear: true,
      sideBySide: true,
    });

    $('input[name="task[tags][]"]:last-of-type').focus();


    if($('p#notice').text()) {
      $.bootstrapGrowl($('p#notice').text(), // Messages
      { // options
        type: "success", // info, success, warning and danger
        ele: "body", // parent container
        offset: {
        from: "bottom",
        amount: 20
        },
        align: "center", // right, left or center
        width: 400,
        delay: 4000,
        allow_dismiss: true, // add a close button to the message
        stackup_spacing: 10
      });
    }

    if($('p#alert').text()) {
      $.bootstrapGrowl($('p#alert').text(), // Messages
      { // options
        type: "danger", // info, success, warning and danger
        ele: "body", // parent container
        offset: {
        from: "bottom",
        amount: 20
        },
        align: "center", // right, left or center
        width: 400,
        delay: 2000,
        allow_dismiss: true, // add a close button to the message
        stackup_spacing: 10
      });
    }

    $('.add-tag-button').on('click', function(event) {
      var $lastTagField;
      event.preventDefault();
      $lastTagField = $('input[name="task[tags][]"]:last-of-type').clone();
      $lastTagField.val("");
      $(".task_tags").append($lastTagField);
      $lastTagField.focus();
    });

  });
