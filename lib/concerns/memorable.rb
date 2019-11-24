# module Concerns::Memorable
#     def ClassMethods
#         def all
#             self.all
#         end
#         def destroy_all
#             all.clear
#         end
#         def create(name)
#             new = self.class.new(name)
#             new.save
#             song
#         end
#     end
#     def InstanceMethods
#         def save
#             self.class.all << self
#         end
#     end
# end

