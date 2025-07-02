function run_adaptive_cutoff_simulation(initial_cutoff; target_acceptance=0.25, 
                                        alpha=0.01, max_steps=100000)

    cutoff = initial_cutoff
    accepted = 0
    total = 0

    history = Float64[]
    acceptance_history = Float64[]

    for step in 1:max_steps
        # Simulate acceptance (replace with your actual criterion)
        value = rand()  # your program's proposed step result
        is_accepted = value < cutoff  # your acceptance logic
        total += 1
        accepted += is_accepted

        # Update acceptance rate every 100 steps (or however often you want)
        if step % 100 == 0
            acceptance_rate = accepted / total

            # Feedback adjustment: shift cutoff to steer acceptance rate
            error = target_acceptance - acceptance_rate
            cutoff += alpha * error  # alpha is a small learning rate

            # Ensure cutoff stays positive
            cutoff = max(cutoff, 1e-8)

            # Store data for analysis
            push!(history, cutoff)
            push!(acceptance_history, acceptance_rate)

            # Reset counts if you want sliding feedback
            accepted = 0
            total = 0
        end

        # Your computation step here using `cutoff`
    end

    return history, acceptance_history
end

# Example run
cutoff_history, accept_history = run_adaptive_cutoff_simulation(0.5)

using Plots
plot(cutoff_history, label="Cutoff", title="Cutoff adaptation over time")
plot!(accept_history, label="Acceptance Rate", xlabel="Iterations (x100)", ylabel="Value")
