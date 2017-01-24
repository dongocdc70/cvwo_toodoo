// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

  $.fn.dataTable.ext.order['dom-completed'] = function  ( settings, col )
  {
      return this.api().column( col, {order:'index'} ).nodes().map( function ( td, i ) {
          return $(td).attr('data-order');
      } );
  };

  $.extend( true, $.fn.dataTable.defaults, {
    "aaSorting": [],
    "autoWidth": false,
    "order": [[1, 'asc'], [2, 'asc']],
    "columnDefs": [
      {
      'orderable': false,
      'targets': [3, 4]
       },
       {
       "orderDataType": "dom-completed",
       "targets": 1
       },
       {
        "width": "30%",
        "targets": 0
       },
       {
        "width": "15%",
        "targets": 1
       },
       {
        "width": "20%",
        "targets": 2
       },
       {
        "width": "20%",
        "targets": 3
       },
       {
        "visible": false,
        "targets": 5
       }

    ],
    "language": {
      "lengthMenu":     "Show _MENU_ tasks",
      "info":           "Showing _START_ to _END_ of _TOTAL_ tasks",
      "infoEmpty":      "",
      "emptyTable":     "No task yet! Enjoy your free time!",

    },

  } );

  $(document).ready(function() {
    var tables = $('table').DataTable({

    });

    var initTinyMCE = function() {
      tinymce.remove("textarea");
      tinymce.init({
        selector: 'textarea',
        height: 200,
        theme: 'modern',
        plugins: [
          'advlist autolink lists charmap print preview hr anchor pagebreak',
          'searchreplace wordcount visualblocks visualchars code fullscreen',
          'insertdatetime nonbreaking save table contextmenu directionality',
          'emoticons template paste textcolor colorpicker textpattern imagetools codesample toc'
        ],
        toolbar1: 'undo redo | insert | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent',
        toolbar2: 'print preview | forecolor backcolor emoticons | codesample',
        image_advtab: true,
       });
    };

    $('input.datetime_picker').datetimepicker({
      format: 'DD/MM/YYYY HH:mm',
      collapse: false,
      toolbarPlacement: 'top',
      showTodayButton: true,
      showClear: true,
      sideBySide: true,
      minDate: moment(),
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

    // $('.add-tag-button').on('click', function(event) {
    //   var $lastTagField = $('input[name="task[tags][]"]:last-of-type');
    //   event.preventDefault();
    //   if($lastTagField.val()) {
    //     $lastTagField = $('input[name="task[tags][]"]:last-of-type').clone();
    //     $lastTagField.val("");
    //     $(".task_tags").append($lastTagField);
    //   }
    //   $lastTagField.focus();
    // });

    $('#tags').val('').prop('selected', true);

    $('#tags').change(function(event) {
      $.ajax({
      url: 'tasks/filter_by_tag',
        dataType: 'html',
        data: {tag: $('#tags option:selected').val()},
      })
      .done(function(response) {
        if($('#filter-by-tag-table table').length) {
          $('#filter-by-tag-table table').DataTable().destroy(true);
        }
        $('#filter-by-tag-table').html(response);
        $('#filter-by-tag-table table').DataTable();
      })
      .fail(function() {
        console.log("error");
      });
    });

    $('.task_tags').on('input', 'input', function() {
      $(this).siblings('input').each(function(index, el) {
        if(!$(this).val()) {
          $(this).remove();
        }
      });
      var $lastTagField = $('input[name="task[tags][]"]:last-of-type');
      if($(this).val()) {
        if($(this) === $lastTagField || $lastTagField.val()) {
          $lastTagField = $lastTagField.clone();
          $lastTagField.val("");
          $(".task_tags").append($lastTagField);
        }
      }
    });

    $('a.show-task').click(function(event) {
      var id = $(this).data('task-id');
      $('#modal-show-task').find('.modal-body').load('/tasks/'+id+' .show-page',
        function(){
        $(this).modal('show');
      });

    });

    $('a.edit-task').click(function(event) {
      var id = $(this).data('task-id');
      $('#modal-edit-task').find('.modal-body').load('/tasks/'+id+'/edit .show-page',
        function(){
        initTinyMCE();
        $(this).modal('show');
      });

    });

    $('button.add-task').click(function(event) {
      initTinyMCE();
    });


  });
