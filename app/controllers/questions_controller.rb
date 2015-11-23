class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!, only: :new
  impressionist actions: [:show]

  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to question_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    @question.upvote_from current_user
    redirect_to :back
  end

  def downvote
    @question.downvote_from current_user
    redirect_to :back
  end

  private

    def set_question
      @question = Question.includes(answers: :user).find(params[:id])
    end

    def question_params
      params.require(:question).permit(:header, :description, :review, :rating, :answer_id).merge(user: current_user)
    end
end
