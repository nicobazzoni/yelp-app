module ReviewsHelper

    def stars(int)
      int.to_i > 0 ? "⭐️" * int.to_i : "No reviews yet!"
    end
  
  end