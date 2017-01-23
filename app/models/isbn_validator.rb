class IsbnValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # :allow_oldパラメータで正規表現を振り分け
    if options[:allow_old]
      pattern = '\A([0-9]{3}-)?[0-9]{1}-[0-9]{3,5}-[0-9]{4}-[0-9x]{1}\z'
    else 
      pattern = '\A[0-9]{3}-[0-9]{1}-[0-9]{3,5}-[0-9]{4}-[0-9x]{1}\z'
    end
    record.errors.add(attribute, 'はただしくないよー') unless value =~ /#{pattern}/
  end
end