class ResponsesController < ApplicationController
  def index
    matching_responses = Response.all

    @list_of_responses = matching_responses.order({ :created_at => :desc })

    render({ :template => "responses/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_responses = Response.where({ :id => the_id })

    @the_response = matching_responses.at(0)

    render({ :template => "responses/show" })
  end

  def create
    the_response = Response.new
    the_response.questions_id = params.fetch("query_questions_id")
    the_response.body_text = params.fetch("query_body_text")
    the_response.role = params.fetch("query_role")

    if the_response.valid?
      the_response.save
      redirect_to("/responses", { :notice => "Response created successfully." })
    else
      redirect_to("/responses", { :alert => the_response.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_response = Response.where({ :id => the_id }).at(0)

    the_response.questions_id = params.fetch("query_questions_id")
    the_response.body_text = params.fetch("query_body_text")
    the_response.role = params.fetch("query_role")

    if the_response.valid?
      the_response.save
      redirect_to("/responses/#{the_response.id}", { :notice => "Response updated successfully."} )
    else
      redirect_to("/responses/#{the_response.id}", { :alert => the_response.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_response = Response.where({ :id => the_id }).at(0)

    the_response.destroy

    redirect_to("/responses", { :notice => "Response deleted successfully."} )
  end
end
