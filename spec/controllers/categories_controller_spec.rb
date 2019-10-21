require 'rails_helper'

describe CategoriesController do
  let(:user) { create(:user) }
  let(:book) { create(:book, users:[user]) }

  describe 'GET #index' do
    context 'not log in' do
      it 'redirects to new_user_session_path' do
        get :index, params: { book_id: book.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #new' do
    context 'log in' do
      before do
        login user
        get :new, params: { book_id: book.id }
      end

      it 'assigns @book' do
        expect(assigns(:book)).to eq book
      end

      it 'assign @category' do
        expect(assigns(:category)).to be_a_new(Category)
      end

      it 'renders the :new template' do
        expect(response).to render_template :new
      end
    end

    context'not log in' do
      it 'redirects to new_user_session_path' do
        get :new, params: {book_id: book.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST #create' do
    let(:params) { {book_id: book.id, category: attributes_for(:category)} }

    context 'log in' do
      before do
        login user
      end

      context 'can save' do
        subject {
          post :create,
          params: params
        }

        it 'count up category' do
          expect{subject}.to change(Category, :count).by(1)
        end

        it 'redirects to book_categorys_path' do
          subject
          expect(response).to redirect_to(book_categories_path(book))
        end
      end

      context 'can not save' do
        let(:invalid_params) {{book_id: book.id, category: attributes_for(:category, name: nil)}}

        subject{
          post :create,
          params: invalid_params
        }

        it 'does not count up' do
          expect{subject}.not_to change(Category, :count)
        end

        it 'renders new' do
          subject
          expect(response).to render_template :new
        end
      end
    end

    context 'not log in' do
      it 'redirects to new_user_session_path' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end

  describe 'GET #edit' do
    let(:category) { create(:category, book_id: book.id) }
    context 'log in' do
      before do
        login user
        category
        get :edit, params: { book_id: book.id, id: category.id }
      end

      it 'assigns @book' do
        expect(assigns(:book)).to eq book
      end

      it 'assigns the requested category to @category' do
        expect(assigns(:category)).to eq category
      end

      it 'renders the :edit template' do
        expect(response).to render_template :edit
      end
    end

    context 'not log in' do
      it 'redirects to new_user_session_path' do
        category = create(:category, book_id: book.id)
        get :edit, params: { book_id: book.id, id: category.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'PATCH #update' do
    let(:category) { create(:category, book_id: book.id) }
    let(:params) { {book_id: book.id, id: category.id, category: attributes_for(:category, name: "更新")} }

    context 'log in' do
      before do
        login user
        category
      end

      context 'can update' do
        subject {
          patch :update,
          params: params
        }

        it 'does not count up' do
          expect{subject}.not_to change(Category, :count)
        end

        it 'updates category' do
          subject
          category.reload
          expect(category.name).to eq "更新"
        end

        it 'redirects to book_categories_path' do
          subject
          expect(response).to redirect_to(book_categories_path(book))
        end
      end

      context 'can not update' do
        let(:invalid_params) {{book_id: book.id, id: category.id, category: attributes_for(:category, name: nil)}}

        subject{
          patch :update,
          params: invalid_params
        }

        it 'renders edit' do
          subject
          expect(response).to render_template :edit
        end
      end
    end

    context 'not log in' do
      it 'redirects to new_user_session_path' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:category) { create(:category, book_id: book.id) }
    let(:params) { {book_id: book.id, id: category.id} }

    context 'not log in' do
      it 'redirects to new_user_session_path' do
        delete :destroy, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end