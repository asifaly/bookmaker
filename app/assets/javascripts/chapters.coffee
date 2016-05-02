@ChapterUtils =
  hideNewChapterForm: ->
    $('#new-chapter-form').hide()
    $('#trigger-new-chapter-form').show()
  bindNewChapterCancelLink: ->
    $('#cancel-chapter-form').click ->
      ChapterUtils.hideNewChapterForm()
$ ->
  $('#new-chapter-form').hide()
  $('#trigger-new-chapter-form').click ->
    $('#new-chapter-form').show()
    $(@).hide()
    
  ChapterUtils.bindNewChapterCancelLink()