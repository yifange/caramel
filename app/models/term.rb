class Term < ActiveRecord::Base
  has_many :programs
  validate :end_date_must_after_start_date, :terms_cannot_overlap

  def last_term
    Term.where("start_date < ?", start_date).order("start_date DESC").first
  end
  def next_term
    Term.where("start_date > ?", start_date).order("start_date ASC").first
  end
  def self.current_term
    Term.find_term(Date.today)
  end
  def self.current_or_next_term
    current_and_future_terms.first
  end
  def self.current_and_future_terms
    where("end_date >= ?", Date.today)
  end
  def in_term?(day)
    # term and (term.start_date <= day and term.end_date >= day)
    start_date <= day and end_date >= day
  end
  def self.in_terms?(day, terms)
    terms.find_index {|term| term.in_term?(day)} != nil
  end
  def self.in_current_term?(day)
    Term.current_term.in_term?(day)
  end
  def self.in_current_or_future_terms?(day)
    Term.in_terms?(day, Term.current_and_future_terms) 
  end
  def self.find_term(day)
    where("start_date <= :day AND end_date >= :day", {:day => day}).first
  end
  def recurring_days(wday)
    start_wday = start_date.wday
    if wday >= start_wday
      first_day = start_date + wday - start_wday
    else
      first_day = start_date + wday + 7 - start_wday
    end
    days = []
    (first_day..end_date).step(7) do |day|
      days << day
    end
    days
  end

  def end_date_must_after_start_date
    if start_date >= end_date
      errors.add(:end_date, "must after start date")
    end
  end

  def terms_cannot_overlap
    Term.find_each do |term|
      if term.id != id and overlap?(term)
        errors.add(:base, "terms overlap")
        return
      end
    end
  end
  def overlap?(term)
    if term.start_date >= end_date or term.end_date <= start_date
      false
    else
      true
    end
  end

end
