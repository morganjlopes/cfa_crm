require 'test_helper'

class NotesControllerTest < ActionController::TestCase
  setup do
    @note = notes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create note" do
    assert_difference('Note.count') do
      post :create, note: { attachment: @note.attachment, body: @note.body, noteable_id: @note.noteable_id, noteable_type: @note.noteable_type, reminder_ds: @note.reminder_ds, reminder_sent_dts: @note.reminder_sent_dts, user_id: @note.user_id }
    end

    assert_redirected_to note_path(assigns(:note))
  end

  test "should show note" do
    get :show, id: @note
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @note
    assert_response :success
  end

  test "should update note" do
    patch :update, id: @note, note: { attachment: @note.attachment, body: @note.body, noteable_id: @note.noteable_id, noteable_type: @note.noteable_type, reminder_ds: @note.reminder_ds, reminder_sent_dts: @note.reminder_sent_dts, user_id: @note.user_id }
    assert_redirected_to note_path(assigns(:note))
  end

  test "should destroy note" do
    assert_difference('Note.count', -1) do
      delete :destroy, id: @note
    end

    assert_redirected_to notes_path
  end
end
