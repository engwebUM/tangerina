//= require jquery-ui
//= require fileinput.min
//= require fancybox
//= require fancybox-media

//= require best_in_place
//= require best_in_place.jquery-ui

  $(".best_in_place").best_in_place();

  $( "#datepicker" ).datepicker({
    dateFormat: "dd-mm-yy"
  });

  $( "#datepicker2" ).datepicker({
    dateFormat: "dd-mm-yy"
  });

  var max_fields = 5;
  var wrapper = $("#input_fields_wrap");
  var add_button = $("#add_field_button");

  var x = 1;
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
