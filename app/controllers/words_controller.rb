class WordsController < ApplicationController
 def index
    @words = Word.all
  end

  def new
    @word = Word.new
  end

  def create
    @word = Word.new(word_params)
    if @word.save
       redirect_to :words, notice: "Succesfully added the word"
    else
       render 'new'
    end
  end

  def show
    @word = Word.find(params[:id])
  end
 
  def letter_display
    @words = Word.all
    @grouped_words =  @words.group_by {|word| word.name[0].upcase}
    @grouped_words = @grouped_words.sort_by{|k, v| k}
  end
  
  def root_display
    @words = Word.all
    @grouped_words =  @words.group_by {|word| word.root}
    @grouped_words = @grouped_words.sort_by{|k, v| k}
  end

  def edit
    @word = Word.find(params[:id])
  end

  def update
    @word = Word.find(params[:id])
 
    if @word.update(word_params)
      redirect_to @word
    else
      render 'edit'
    end
  end

  def destroy
    @word = Word.find(params[:id])
    @word.destroy
    redirect_to words_path
  end
   
  private

  def word_params
    params.require(:word).permit(:name, :meaning, :context, :sentence, :synonym, 
                                 :root)
  end

end
