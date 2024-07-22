#ifndef TASK_ODE_SYSTEM_SOLUTION_HXX
#define TASK_ODE_SYSTEM_SOLUTION_HXX

#include "all.hxx"
#include "math_vector.hxx"
#include "tasks.hxx"

using U_arg = Math_Vector<double>;

template <typename U_arg>
class task_ode_system_solution
{
    public:
        task_ode_system_solution() = default;
        ~task_ode_system_solution() = default;

        void completing_a_task();

    private:
};

template <typename U_arg>
void task_ode_system_solution<U_arg>::completing_a_task()
{
    constexpr int equations_amount = 2;

    constexpr double frequency = 1.0;

    constexpr double t_start = 0.0;
    constexpr double t_end = 100.0;
    constexpr int time_steps_amount = 10'000;
    constexpr double dt = t_end / time_steps_amount;

    auto ode_system = [&](const U_arg& u, const double t)-> U_arg
    {
        const double frequency_sqr = frequency * frequency;
        return {{u[1], -frequency_sqr * u[0]}};
    };

    auto exact_solution = [frequency](const double t)-> U_arg
    {
        return {{std::cos(frequency * t), -std::sin(frequency * t)}};
    };

    auto initial_conditions = []()-> U_arg
    {
        return {{1.0, 0.0}};
    };

    U_arg start_solution = initial_conditions();


    RKM_explicit<U_arg, double> rkm_solver_ex(ode_system, start_solution, t_start, dt, 2);
    RMK_implicit<U_arg, double> rkm_solver_im(ode_system, start_solution, t_start, dt, 2);
    MSM<U_arg, double> msm_solver(ode_system, start_solution, t_start, dt, 2);
    auto get_solution = [&]()
    {
        std::ofstream output_data("result.dat", std::ios::trunc);
        for(int i = 0; i < time_steps_amount; i++)
        {
            double t = t_start + i * dt;
            U_arg res_exact_solution = exact_solution(t);
            output_data << t << " \t " << rkm_solver_im.get_Solution() <<  "\t" << rkm_solver_ex.get_Solution() <<  "\t" << msm_solver.get_Solution()  <<  "\t"  << res_exact_solution << "\n";

        }
        output_data.flush();
        output_data.close();
    };
    get_solution();

    return 0;
}
}

#endif // TASK_ODE_SYSTEM_SOLUTION_HXX
