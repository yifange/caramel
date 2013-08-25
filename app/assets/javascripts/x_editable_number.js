/**
  number editable input.

  @class number
  @extends abstractinput
  @final
  @example
  <a href="#" id="number" data_type="number" data-pk="1"></a>
  <script>
    $(function(){
      $('#number').editable({
        url: '',
        type: 'number' 
      });
    });
  </script>
 **/
(function ($) {
  "use strict";

  var number = function (options) {
    this.init('number', options, number.defaults);
  };

  //inherit from Abstract input
  $.fn.editableutils.inherit(number, $.fn.editabletypes.abstractinput);

  $.extend(number.prototype, {
    /**
      Renders input from tpl

      @method render() 
     **/        
    render: function() {
      this.$input = this.$tpl.find('input');
    },

    /**
      Default method to show value in element. Can be overwritten by display option.

      @method value2html(value, element) 
     **/
    value2html: function(value, element) {
      if(!value) {
        $(element).empty();
        return; 
      }
      var html = value.regular_courses_per_year + ' / ' + value.group_courses_per_year;
      $(element).html(html); 
    },

    /**
      Gets value from element's html

      @method html2value(html) 
     **/        
    html2value: function(html) {
      return {
        regular_courses_per_year: html.split(" ")[0], 
        group_courses_per_year: html.split(" ")[2] 
      };
    },

    /**
      Converts value to string. 
      It is used in internal comparing (not for sending to server).

      @method value2str(value)  
     **/
    value2str: function(value) {
      var str = '';
      if(value) {
        for(var k in value) {
          str = str + k + ':' + value[k] + ';';  
        }
      }
      return str;
    }, 

    /*
       Converts string to value. Used for reading value from 'data-value' attribute.

       @method str2value(str)  
       */
    str2value: function(str) {
      /*
         this is mainly for parsing value defined in data-value attribute. 
         If you will always set value by javascript, no need to overwrite it
         */
      return str;
    },                

    /**
      Sets value of input.

      @method value2input(value) 
      @param {mixed} value
     **/         
    value2input: function(value) {
      if(!value) {
        return;
      }
      this.$input.filter('[name="regular_courses_per_year"]').val(value.regular_courses_per_year);
      this.$input.filter('[name="group_courses_per_year"]').val(value.group_courses_per_year);
    },       

    /**
      Returns value of input.

      @method input2value() 
     **/          
    input2value: function() { 
      return {
        regular_courses_per_year: this.$input.filter('[name="regular_courses_per_year"]').val(), 
        group_courses_per_year: this.$input.filter('[name="group_courses_per_year"]').val(), 
      };
    },        

    /**
      Activates input: sets focus on the first field.

      @method activate() 
     **/        
    activate: function() {
      this.$input.filter('[name="regular_courses_per_year"]').focus();
    },  

    /**
      Attaches handler to submit form in case of 'showbuttons=false' mode

      @method autosubmit() 
     **/       
    autosubmit: function() {
      this.$input.keydown(function (e) {
        if (e.which === 13) {
          $(this).closest('form').submit();
        }
      });
    }       
  });

  number.defaults = $.extend({}, $.fn.editabletypes.abstractinput.defaults, {
    tpl: '<div class="x-editable-user-name"><input type="text" name="regular_courses_per_year" class="input-small name-input" placeholder="regular class"><input type="text" name="group_courses_per_year" class="input-small" placeholder="group class"></div>',
    inputclass: ''
  });

  $.fn.editabletypes.number = number;

}(window.jQuery));
