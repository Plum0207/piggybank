require 'rails_helper'

describe RecordsController do
  let(:user) { create(:user) }
  let(:book) { create(:book, users:[user]) }

  describe 'GET #index' do
    context 'log in' do
      before do
        login user
        get :index, params: { book_id: book.id }
      end

      it 'assigns @book' do
        expect(assigns(:book)).to eq book
      end

      it 'populates an array of records ordered by created_at DESC' do
        records = create_list(:record, 3, book_id: book.id)
        expect(assigns(:records)).to match(records.sort{ |a,b| b.created_at <=> a.created_at })
      end

      it 'renders the :index template' do
        expect(response).to render_template :index
      end
    end

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

      it 'assign @record' do
        expect(assigns(:record)).to be_a_new(Record)
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
    let(:params) { {book_id: book.id, record: attributes_for(:record)} }

    context 'log in' do
      before do
        login user
      end

      context 'can save' do
        subject {
          post :create,
          params: params
        }

        it 'count up record' do
          expect{subject}.to change(Record, :count).by(1)
        end

        it 'redirects to book_records_path' do
          subject
          expect(response).to redirect_to(book_records_path(book))
        end
      end

      context 'can not save' do
        let(:invalid_params) {{book_id: book.id, record: attributes_for(:record, content: nil)}}

        subject{
          post :create,
          params: invalid_params
        }

        it 'does not count up' do
          expect{subject}.not_to change(Record, :count)
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
    let(:record) { create(:record, book_id: book.id) }
    context 'log in' do
      before do
        login user
        record
        get :edit, params: { book_id: book.id, id: record.id }
      end

      it 'assigns @book' do
        expect(assigns(:book)).to eq book
      end

      it 'assigns the requested record to @record' do
        expect(assigns(:record)).to eq record
        binding
      end

      it 'renders the :edit template' do
        expect(response).to render_template :edit
      end
    end

    context 'not log in' do
      it 'redirects to new_user_session_path' do
        record = create(:record, book_id: book.id)
        get :edit, params: { book_id: book.id, id: record.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'PATCH #update' do
    let(:record) { create(:record, book_id: book.id) }
    let(:params) { {book_id: book.id, id: record.id, record: attributes_for(:record, content: "更新")} }

    context 'log in' do
      before do
        login user
        record
      end

      context 'can update' do
        subject {
          patch :update,
          params: params
        }

        it 'does not count up' do
          expect{subject}.not_to change(Record, :count)
        end

        it 'updates record' do
          subject
          record.reload
          expect(record.content).to eq "更新"
        end

        it 'redirects to book_records_path' do
          subject
          expect(response).to redirect_to(book_records_path(book))
        end
      end

      context 'can not update' do
        let(:invalid_params) {{book_id: book.id, id: record.id, record: attributes_for(:record, content: nil)}}

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
    let(:record) { create(:record, book_id: book.id) }
    let(:params) { {book_id: book.id, id: record.id} }

    context 'not log in' do
      it 'redirects to new_user_session_path' do
        delete :destroy, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end