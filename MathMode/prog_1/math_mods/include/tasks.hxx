#ifndef TASKS_H
#define TASKS_H

#include "all.hxx"
#include "ODE_Solver.hxx"
using U_arg = Math_Vector<double>;

namespace TASKS
{
    void standart_example() // oscillator
    {
        std::cout << "\t \t Solution : Oscillator" << std::endl;

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
        RKM_implicit<U_arg, double> rkm_solver_im(ode_system, start_solution, t_start, dt, 3);
        MSM<U_arg, double> msm_solver(ode_system, start_solution, t_start, dt, 3);
        auto get_solution = [&]()
        {
            std::ofstream output_data("task_result/res_oscillator.dat", std::ios::trunc);
            for(int i = 0; i < time_steps_amount; i++)
            {
                double t = t_start + i * dt;
                U_arg res_exact_solution = exact_solution(t);
                output_data << t << " \t " << rkm_solver_im.get_Solution() << "\t"
                            << rkm_solver_ex.get_Solution() << "\t"
                            << msm_solver.get_Solution() << "\t"
                            << res_exact_solution << "\n";
            }
            output_data.flush();
            output_data.close();
        };
        get_solution();
    }

    void individal_ode_system() // individual_task
    {
        std::cout << "\t \t Solution : Individal_ode_system" << std::endl;

    constexpr int equations_amount = 2;
    constexpr double gamma = 3.0;
    constexpr double tetta_start = 1.0;

    constexpr double t_start = 0.0;
    constexpr double t_end = 100.0;
    constexpr int time_steps_amount = 10'000;
    constexpr double dt = t_end / time_steps_amount;

    auto ode_system = [&](const U_arg& u, const double t)-> U_arg
    {
        double cos_tetta = std::cos(u[0]);
        double sin_tetta = std::sin(u[0]);
        double sin_2_tetta = std::sin(2*u[0]);
        double denom = 1 + 2 * std::sin(u[0]) * std::sin(u[0]);
        double term_1 = (0.5*gamma*gamma - u[1]*u[1]) * sin_2_tetta;
        double term_2 = - 2*sin_tetta;
        return{{u[1], (term_1 + term_2)/denom}};
    };


    auto initial_conditions = []()-> U_arg
    {
        return {{tetta_start, 0.0}};
    };

        U_arg start_solution = initial_conditions();

        RKM_explicit<U_arg, double> rkm_solver_ex(ode_system, start_solution, t_start, dt, 2);
        RKM_implicit<U_arg, double> rkm_solver_im(ode_system, start_solution, t_start, dt, 3);
        MSM<U_arg, double> msm_solver(ode_system, start_solution, t_start, dt, 3);
        auto get_solution = [&]()
        {
            std::ofstream output_data("task_result/res_individual.dat", std::ios::trunc);
            for(int i = 0; i < time_steps_amount; i++)
            {
                double t = t_start + i * dt;
                output_data << t << " \t " << rkm_solver_ex.get_Solution()/tetta_start <<  "\t"
                            << rkm_solver_im.get_Solution()/tetta_start << "\t"
                            << msm_solver.get_Solution()/tetta_start << "\t" << "\n";
            }
            output_data.flush();
            output_data.close();
        };

        get_solution();
    }

    void task_ode_system_solution()
    {
        std::cout << "\t Task_1: " << std::endl;

        standart_example(); //oscillator
        individal_ode_system(); //system task
    }


    void run(const int number_task)
    {
        switch(number_task)
        {
            case 1 : {task_ode_system_solution(); } break;
            default : {std::cout << "Error! number_task don't seached" << std::endl;}
        }
    }
}

#endif // TASKS_H

