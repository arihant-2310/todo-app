class CommentsController < ApplicationController
  def create
    @task = Task.find(comment_params[:task_id])
    @comment = @task.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.task, notice: "Comment was successfully added." }
      else
        format.html { redirect_to @comment.task, alert: "Failed to post comment" }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :task_id)
  end
end
