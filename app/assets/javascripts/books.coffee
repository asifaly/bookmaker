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

  orderedSections: (el) ->
    #console.log(JSON.stringify el.sortable('toArray'))
    #console.log(el.sortable( "serialize", { key: el[0].dataset.chapterId } ))
    sectionOrder = JSON.stringify el.sortable('toArray').map (el) ->
      el.split("_")[1]
    chapterId = el[0].dataset.chapterId
    console.log(chapterId)
    SorterUtils.saveSectionSortOrder(sectionOrder, chapterId)
        
  saveSectionSortOrder: (s,c)->
    $.ajax
      method: 'PUT'
      url: "/books/#{$('#book')[0].dataset.bookId}#{'/chapters/'}#{c}"
      dataType: 'script'
      data:
        chapter:
          sorted_section_ids: s

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
        console.log("from chapter id : ", ui.sender[0].dataset.chapterId)
        console.log("section id : ", ui.item[0].dataset.sectionId)
        console.log("to chapter id : ", ui.item.parent()[0].dataset.chapterId)
        SorterUtils.orderedSections(ui.sender)
        SorterUtils.orderedSections(ui.item.parent())
      update: ->
        console.log("updated")
        #SorterUtils.saveSectionSortOrder()
  
