class Task < ApplicationRecord
  enum priority: { low: 1, medium: 2, urgent:3 }
end
