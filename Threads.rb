#!/usr/bin/ruby


# Add a callback into this.

def reverse (sum)
	if sum == 0
		puts 'At the end!'
		return
	elsif sum % 3 == 0
		make_new_thread sum
		reverse (sum-1)
	else
		puts "Main thread " + sum.to_s + "\n"
		sleep Random.rand(4)
		reverse (sum-1)
	end	

end

def make_new_thread (sum)
	tt = Thread.new {
		#sleep 0.5 + Random.rand(5)
		#puts "  Sub-thread " + sum.to_s + " - " + (sum * 0.25).to_s
		sums = Random.rand(1000) * (17 - sum)
		aggregate = 0
		while (sums > 0) 
			aggregate += sums
			sums -= 1
		end
		puts "   Sub-thread " + sum.to_s + " calculated: " + aggregate.to_s + "\n"

	}
	@thread_pool << tt
end

@thread_pool = []
puts 'starting'
reverse 16
@thread_pool.each { |t|  t.join }
puts 'Completed'
