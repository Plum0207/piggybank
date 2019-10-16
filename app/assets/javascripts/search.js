$(function(){

  function appendUser(user){
    let html = `<div class="book-user mb-2 border-bottom d-flex justify-content-between">
                  <p class="book-user__name">${ user.name }</p>
                  <a class="book-user__btn book-user__btn--add text-primary" data-user-id="${ user.id }" data-user-name="${ user.name }">追加</a>
                </div>`
    $("#user-search-result").append(html);
  }

  function appendErrMsgToHTML(msg){
    let html = `<div class="book-user mb-2 border-bottom">
                  <p class="book-user__name">${ msg }</p>
                </div>`
    $("#user-search-result").append(html);
  }

  function appendUserToBook(userId, userName){
    let html = `<div class="book-user mb-2 border-bottom d-flex justify-content-between">
                  <input name='book[user_ids][]' type='hidden' value=${ userId }>
                  <p class="book-user__name">${ userName }</p>
                  <a class="book-user__btn book-user__btn--remove text-secondary">削除</a>
                </div>`
    $(".book-users").append(html);
  }

  $("#user-search-field").on("keyup", function(){
    let input = $("#user-search-field").val();

    $.ajax({
      type: 'GET',
      url: '/users',
      data: { search: input },
      dataType: 'json'
    })

    .done(function(users){
      $("#user-search-result").empty();
      if(input.length == 0){
      }
      else if(users.length !==0){
        users.forEach(function(user){
          appendUser(user);
        });
      }
      else {
        appendErrMsgToHTML('一致するユーザーが見つかりません');
      }
    })
    .fail(function(){
      alert('ユーザー検索に失敗しました');
    })

  })

  $("#user-search-result").on('click', ".book-user__btn--add",function(){
    $(this).parent().remove();
    let userId = $(this).data("user-id");
    let userName = $(this).data("user-name");
    appendUserToBook(userId, userName);
  });

  $(".book-users").on('click', ".book-user__btn--remove", function(){
    $(this).parent().remove();
  });

})