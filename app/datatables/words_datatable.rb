class WordsDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Word.count,
      iTotalDisplayRecords: words.total_entries,
      aaData: data
    }
  end

private

  def data
    words.map do |word|
      [
        link_to(word.name, word),
        h(word.meaning),
        h(word.synonym),
        h(word.sentence),
        h(word.root),
        h(word.context)
      ]
    end
  end

  def words
    @words ||= fetch_words
  end

  def fetch_words
    words = Word.order("#{sort_column} #{sort_direction}")
    words = words.page(page).per_page(per_page)

    if params[:sSearch].present?
      words = words.where("name like :search or meaning like :search or root like :search", search: "%#{params[:sSearch]}%")
    end
    words
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name root context]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
                                                                                                                             61,1          


