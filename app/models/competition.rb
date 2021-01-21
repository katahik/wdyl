class Competition < ApplicationRecord
    has_many :items

    # scopeはActiveRecordのQueryメソッドに名前をつける機能
    scope :search, -> (search_params) do
        # search_paramsが空の場合は以降の処理は行わない
        # bland?中身が空かそもそも入れ物が存在するかどうか判断するとき使う
        return if search_params.blank?

        # パラメータを指定して検索を実行する
        name_like(search_params[:name])
            .period_start(search_params[:period_start])
            .period_end(search_params[:period_end])
    end

    scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
    scope :period_start, -> (period_start) { where('period_start LIKE ?', "%#{period_start}%") if period_start.present? }
    scope :period_end, -> (period_end) { where('period_end LIKE ?', "%#{period_end}%") if period_end.present? }

end
