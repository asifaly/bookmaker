

$ ->
  $('#book #sidebar #chapters-list .chapter .chapter-title').click (ev) ->
    ev.preventDefault()
    $(@).parents('.chapter').toggleClass('expanded')

  SorterUtils.init()

SorterUtils =
  orderedChapters: ->
    JSON.stringify $('#chapters-list').sortable('toArray').map (el) ->
      el.split("_")[1]
  saveSortOrder: ->
    $.ajax
      method: 'PUT'
      url: "/books/#{$('#book')[0].dataset.bookId}"
      dataType: 'script'
      data:
        book:
          sorted_chapter_ids: SorterUtils.orderedChapters()
  init: ->
    $('#chapters-list').sortable
      handle: '.fa-bars'
      items: '> .chapter'
      placeholder: 'sortable-placeholder'
      update: ->
        SorterUtils.saveSortOrder()
