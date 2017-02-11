module Admin::ProjectsHelper

  def display_product_quotation(product)
    @rank_price_str = ""
    if product.quotations && product.quotations.size > 0
      product.quotations.each do |quotation|
        if quotation.agent_rank
          @rank_price_str += "#{quotation.agent_rank.name}：#{quotation.price} \r\n"
        end
      end
    else
      @rank_price_str = "未设置"
    end

    simple_format(@rank_price_str)
  end

end
