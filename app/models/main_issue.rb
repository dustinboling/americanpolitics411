class MainIssue < ActiveRecord::Base
  has_many :issue_main_issues
  has_many :issues, :through => :issue_main_issues
end
