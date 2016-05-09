

$ ->
  $('#book #sidebar #chapters-list .chapter .chapter-title').click (ev) ->
    ev.preventDefault()
    $(@).parents('.chapter').toggleClass('expanded')

  SorterUtils.initChapterSort()
  SorterUtils.initSectionSort()

SorterUtils =
  orderedChapters: ->
    JSON.stringify $('#chapters-list').sortable('toArray').map (el) ->
      el.split("_")[1]

  saveChapterSortOrder: ->
    $.ajax
      method: 'PUT'
      url: "/books/#{$('#book')[0].dataset.bookId}"
      dataType: 'script'
      data:
        book:
          sorted_chapter_ids: SorterUtils.orderedChapters()

  orderedSections: ->
    JSON.stringify $('.sections-list').sortable('toArray').map (el) ->
      el.split("_")[1]
        
  saveSectionSortOrder: ->
    $.ajax
      method: 'PUT'
      url: "/books/#{$('#book')[0].dataset.bookId}#{'/chapters/'}#{$('.chapter')[0].dataset.chapterId}"
      dataType: 'script'
      data:
        book:
          sorted_section_ids: SorterUtils.orderedSections()

  initChapterSort: ->
    $('#chapters-list').sortable
      handle: '.fa-bars'
      items: '> .chapter'
      placeholder: 'sortable-placeholder'
      update: ->
        SorterUtils.saveChapterSortOrder()

  initSectionSort: ->
    $('.sections-list').sortable
      handle: '.fa-bars'
      items: '.section'
      placeholder: 'sortable-placeholder'
      connectWith: '.sections-list'
      receive: (event, ui) ->
        console.log(ui)
        console.log("chapter id : ", ui.sender[0].dataset.chapterId)
        console.log("section id : ", ui.item[0].dataset.sectionId)
      update: ->
        SorterUtils.saveSectionSortOrder()
  
