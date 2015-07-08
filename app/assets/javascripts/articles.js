//= require jquery-ui
//= require fileinput.min
//= require fancybox
//= require fancybox-media

//= require best_in_place
//= require best_in_place.jquery-ui

  $(".best_in_place").best_in_place();

  $( "#datepicker" ).datepicker({
    dateFormat: "dd-mm-yy",
    onSelect: function (date) {
      var date2 = $('#datepicker').datepicker('getDate');
      date2.setDate(date2.getDate() + 1);
      $('#datepicker2').datepicker('setDate', date2);
      //sets minDate to datepicker date + 1
      $('#datepicker2').datepicker('option', 'minDate', date2);
    }
  });

  $( "#datepicker2" ).datepicker({
    dateFormat: "dd-mm-yy",
    onClose: function () {
      var datepicker = $('#datepicker').datepicker('getDate');
      var datepicker2 = $('#datepicker2').datepicker('getDate');
      //check to prevent a user from entering a date below date of datepicker
      if (datepicker2 <= datepicker) {
          var minDate = $('#datepicker2').datepicker('option', 'minDate');
          $('#datepicker2').datepicker('setDate', minDate);
      }
    }
  });

  $( "#datepicker3" ).datepicker({
    dateFormat: "dd-mm-yy",
    onSelect: function (date) {
      var date2 = $('#datepicker3').datepicker('getDate');
      date2.setDate(date2.getDate() + 1);
      $('#datepicker4').datepicker('setDate', date2);
      //sets minDate to datepicker3 date + 1
      $('#datepicker4').datepicker('option', 'minDate', date2);
    }
  });

  $( "#datepicker4" ).datepicker({
    dateFormat: "dd-mm-yy",
    onClose: function () {
      var datepicker3 = $('#datepicker3').datepicker('getDate');
      var datepicker4 = $('#datepicker4').datepicker('getDate');
      //check to prevent a user from entering a date below date of datepicker
      if (datepicker4 <= datepicker3) {
          var minDate = $('#datepicker4').datepicker('option', 'minDate');
          $('#datepicker4').datepicker('setDate', minDate);
      }
    }
  });

  var max_fields = 5;
  var wrapper = $("#input_fields_wrap");
  var add_button = $("#add_field_button");

  var x = 0;
  $(add_button).click(function(e){
    e.preventDefault();
    if(x < max_fields){
      x++;
      $(wrapper).append('<div class="form-group"><input type="text" class="form-control" name="videos[link][]"/><a href="#" id="remove_field">Remove</a></div>');
    }
  });

  $(wrapper).on("click","#remove_field", function(e){ //user click on remove text
      e.preventDefault(); $(this).parent('div').remove(); x--;
  })

  $('#file-1').fileinput({
    showUpload: false,
    showCaption: false,
    allowedFileExtensions: ['jpg', 'png', 'pdf'],

  });
