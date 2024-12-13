class QuestionsController < ApplicationController
  def index
    matching_questions = Question.all

    @list_of_questions = matching_questions.order({ :created_at => :desc })

    render({ :template => "questions/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_questions = Question.where({ :id => the_id })

    @the_question = matching_questions.at(0)

    render({ :template => "questions/show" })
  end

  def create
    the_question = Question.new
    the_question.topic = params.fetch("query_topic")

    if the_question.valid?
      the_question.save
      
      # Create system message
      system_response = Response.new
      system_response.questions_id = the_question.id
      system_response.role = "system"
      system_response.body_text = "I am a helpful #{the_question.topic} expert who talks like Shakespeare. What do you need help with today?"
      
      system_response.save

      # Create first user message
      user_response = Response.new
      user_response.role = "user"
      user_response.questions_id = the_question.id
      user_response.body_text = "Can you help me with #{the_question.topic}?"

      user_response.save

      # Call API to get first assistant message
      client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))

      message_list = [
        {
          "role" => "system",
          "content" => "You are a helpful #{the_question.topic} expert who talks like Shakespeare. What do you need help with today?"
        },
        {
          "role" => "user",
          "content" => "Can you help me with #{the_question.topic}?"
        }
      ]

      api_response = client.chat(
        parameters: {
          model: "gpt-4o",
          messages: message_list
        }
      )
      
      assistant_content = api_response.fetch("choices").at(0).fetch("message").fetch("content")

      assistant_response = Response.new
      assistant_response.role = "assistant"
      assistant_response.questions_id = the_question.id
      assistant_response.body_text = assistant_content

      assistant_response.save

      redirect_to("/questions/#{the_question.id}", { :notice => "Question created successfully." })
    else
      redirect_to("/questions/#{the_question.id}", { :alert => the_question.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_question = Question.where({ :id => the_id }).at(0)

    the_question.topic = params.fetch("query_topic")

    if the_question.valid?
      the_question.save
      redirect_to("/questions/#{the_question.id}", { :notice => "Question updated successfully."} )
    else
      redirect_to("/questions/#{the_question.id}", { :alert => the_question.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_question = Question.where({ :id => the_id }).at(0)

    the_question.destroy

    redirect_to("/questions", { :notice => "Question deleted successfully."} )
  end
end
