class WEB::SearchesController < ApplicationController
  layout 'web'

  def phrases
    @page_title = 'Buscar'
    search do
      Phrase.where('phrase LIKE :t', { t: "%#{params[:q]}%" }).includes(:category).paginate(page: params[:page], per_page: 15)
    end
  end

  def phrases_count
    search do
      Phrase.where('phrase LIKE :t', { t: "%#{params[:q]}%" }).count
    end
  end

  private

  def search(&block)
    if params[:q]
      @results = yield if block_given?
    else
      redirect_to web_root_url, notice: 'No se ha especificado la consulta.'
    end
  end
end
