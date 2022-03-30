Spree.routes.pages_api = Spree.pathFor('api/v1/pages');

$.fn.pageAutocomplete = function () {
  'use strict'

  function formatPageList(pages) {
    return pages.map(function(obj) {
      return { id: obj.id, text: obj.title }
    })
  }

  this.select2({
    minimumInputLength: 3,
    ajax: {
      url: Spree.routes.pages_api,
      dataType: 'json',
      data: function (params) {
        return {
          q: {
            title_cont: params.term
          },
          token: Spree.api_key
        }
      },
      processResults: function(data) {
        var pages = data.pages ? data.pages : []
        var results = formatPageList(pages)

        return {
          results: results
        }
      }
    }
  })
}

$(document).ready(function () {
  $('.page_picker').pageAutocomplete()
})
