$ ->
  $("#bento").select2({
    formatResultCssClass: ->
    # formatSelection: (item) ->
    #   # originalOption = item.element
    #   console.log(item)
    #   item.text
  })
  $(".dropdown-menu.strange").on "click", "#show-in-calendar", (e) ->
    e.preventDefault()
    alert('helo')

  # $(".dropdown-menu a").on "click", ->
  #   # console.log($("p", this).html())
  #   $("a.dropdown-toggle").text($("p", this).text())

  $(".hah").tooltip({
    placement: "left"
  })
  $("#username").editable({
    url : "/lunchpads",
    title: "Enter username"
  })
  # $.fn.editable.defaults.mode = 'inline'
  # $("#country").editable({
  #   # tags: true,
  #   # showbuttons: false, # source: [{id: 'gb', text: "Great Britain"}] # autotext: "never",
  #   # select2: {
  #   #   multiple: true
  #   # }
  # })
  # $("#bfast").on("select2-blur", ->
  #   # alert($(this).val())
  # )
  # $("#bfast").select2({
  #   width: "300px"
  #   multiple: true
  #   # data: (->
  #   #   data = []

  #     # $($("#bfast").data("options").split(",")).each( ->
  #     #   item = this.split(":")
  #     #   data.push({
  #     #     id: item[0],
  #     #     text: item[1]
  #     #   })
  #     # )
  #     # data)()

  #   ajax: {
  #     url: "/lunchpads/api",
  #     dataType: "json",
  #     results: (data, page) ->
  #       {results: data}
  #   }
  #   formatSelection: (object, container) ->
  #     console.log("object")
  #     console.log(object)
  #     console.log("container")
  #     console.log(container)
  #     return $("<span>", {id: "bfast-" + object.id}).text(object.text)[0].outerHTML

  #   initSelection: (element, callback) ->
  #     data = []
  #     $(element.val().split(",")).each( ->

  #       item = this.split(":")
  #       data.push({
  #         id: item[0],
  #         text: item[1]
  #       })
  #     )
  #     element.val('')
  #     callback(data)
  # })

  # $(".select2-choices").on "click", ".select2-search-choice", ->
  #   alert($(this).find("span").text())

