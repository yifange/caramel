$ ->
  $(".dropdown-menu a").on "click", ->
    # console.log($("p", this).html())
    $("a.dropdown-toggle").text($("p", this).text())

  $(".hah").tooltip({
    placement: "left"
  })
  $("#username").editable({
    url : "/lunchpads",
    title: "Enter username"
  })
  $.fn.editable.defaults.mode = 'inline'
  $("#country").editable({
    # tags: true,
    # showbuttons: false,
    # source: [{id: 'gb', text: "Great Britain"}]
    # autotext: "never",
    # select2: {
    #   multiple: true
    # }
  })
  $("#bfast").on("select2-blur", ->
    alert($(this).val())
  )
  $("#bfast").select2({
    width: "300px"
    multiple: true
    data: (->
      data = []

      $($("#bfast").data("options").split(",")).each( ->
        item = this.split(":")
        data.push({
          id: item[0],
          text: item[1]
        })
      )
      data)()

    # ajax: {
    #   url: "/lunchpads/api",
    #   dataType: "json", #   results: (data, page) ->
    #     {results: data}
    # }

    initSelection: (element, callback) ->
      data = []
      $(element.val().split(",")).each( ->

        item = this.split(":")
        data.push({
          id: item[0],
          text: item[1]
        })
      )
      element.val('')
      callback(data)
  }).change((e) ->
    # alert("changed")
  )

