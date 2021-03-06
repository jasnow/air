class CatRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :cat

  def fulfill
    sleep 5 # Pretend this is harder than it really is
    update_attributes cat: Cat.choose
    if RUBY_PLATFORM == "i686-linux"
      `gnome-open #{cat.download_path}`
    else
      `open #{cat.download_path} -a 'Google Chrome'`
    end
  end
end
