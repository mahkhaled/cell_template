// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function live_search(){
  $.get($(".searchable").attr("action"), $(".searchable").serialize(), null, "script");
}
$(function() {
  
  $(".sortable th a, .paginated .pagination a").live("click", function() {
    $.getScript(this.href);
    $(".searchable #sort").val(getUrlVars(this.href)["sort"]);
    $(".searchable #direction").val(getUrlVars(this.href)["direction"]);
    return false;
  });
  
  $(".searchable input").keyup(function() {
    live_search();
    return false;
  });
  $(".searchable select").change(function() {
    live_search();
    return false;
  });
  $(".searchable input[type=checkbox]").click(function() {
    live_search();
    return false;
  });
  
  // Hides the submit button
  $('.new_rating').children('input[type=submit]').addClass('hide');
  
  /* fix datepicker issue with client_side_validation */
  $( ".datepicker" ).datepicker({ dateFormat: 'dd-mm-yy', 
    onClose: function(dateText, inst) { 
      field = $("#"+inst.id);
      form=field.parents("form");
      var settings = window[form.attr('id')];
      field.isValid(settings.validators); 
    }
  });

  // reload listing page
  $('.searchable input, .searchable select').attr('autocomplete', 'off');
  loadColorBox();
});

function loadColorBox(){
  $('.popup_link').colorbox(
    {onComplete : function() { 
      // resize when some contents change size ex: validation
      $("#cboxLoadedContent form").resize(function(e){
        $.colorbox.resize(); 
      }); 
      }
    });
  // resize when ajax response
  $.colorbox.resize(); 
}

function submitAjaxFileUpload(url, fileElementId, formInputsSelector)
{
  var data = [];
  $(formInputsSelector).each(function(){
    // don't include unchecked checkboxes
    // don't include file inputs
    if((this.type!="checkbox" || this.checked) && this.type!='file')
      data.push([this.name,this.value]);
  });
  
  $.ajaxFileUpload
  (
    {
        url:url, 
        data: data,
        dataType: 'script',
        secureuri:false,
        fileElementId:fileElementId
    }
  )
      
  return false;
} 