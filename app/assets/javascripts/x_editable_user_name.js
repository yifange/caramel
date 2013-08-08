/**
  userName editable input.

  @class userName
  @extends abstractinput
  @final
  @example
  <a href="#" id="user-name" data_type="user_name" data-pk="1"></a>
  <script>
    $(function(){
      $('#user-name').editable({
        url: '',
        type: 'user_name' 
      });
    });
  </script>
 **/
(function ($) {
  "use strict";

  var userName = function (options) {
    this.init('user_name', options, userName.defaults);
  };

  //inherit from Abstract input
  $.fn.editableutils.inherit(userName, $.fn.editabletypes.abstractinput);

  $.extend(userName.prototype, {
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
      var html = value.first_name + ' ' + value.last_name;
      $(element).html(html); 
    },

    /**
      Gets value from element's html

      @method html2value(html) 
     **/        
    html2value: function(html) {
      return {
        first_name: html.split(" ")[0], 
        last_name: html.split(" ")[1] 
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
      this.$input.filter('[name="first_name"]').val(value.first_name);
      this.$input.filter('[name="last_name"]').val(value.last_name);
    },       

    /**
      Returns value of input.

      @method input2value() 
     **/          
    input2value: function() { 
      return {
        first_name: this.$input.filter('[name="first_name"]').val(), 
        last_name: this.$input.filter('[name="last_name"]').val(), 
      };
    },        

    /**
      Activates input: sets focus on the first field.

      @method activate() 
     **/        
    activate: function() {
      this.$input.filter('[name="first_name"]').focus();
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

  userName.defaults = $.extend({}, $.fn.editabletypes.abstractinput.defaults, {
    tpl: '<div class="x-editable-user-name"><input type="text" name="first_name" class="input-small name-input"><input type="text" name="last_name" class="input-small"></div>',
    inputclass: ''
  });

  $.fn.editabletypes.user_name = userName;

}(window.jQuery));
