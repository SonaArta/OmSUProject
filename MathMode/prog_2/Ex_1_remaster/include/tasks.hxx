#ifndef TASKS_HXX
#define TASKS_HXX


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
        RMK_implicit<U_arg, double> rkm_solver_im(ode_system, start_solution, t_start, dt, 3);
        MSM<U_arg, double> msm_solver(ode_system, start_solution, t_start, dt, 3);
        auto get_solution = [&]()
        {
            std::ofstream output_data("task_1_result/res_oscillator.dat", std::ios::trunc);
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
    constexpr double gamma = 2.0;
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
        RMK_implicit<U_arg, double> rkm_solver_im(ode_system, start_solution, t_start, dt, 2);
        MSM<U_arg, double> msm_solver(ode_system, start_solution, t_start, dt, 2);
        auto get_solution = [&]()
        {
            std::ofstream output_data("task_1_result/res_individual.dat", std::ios::trunc);
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

    double exact_func(const double x) //точная функция
    {
        const double sin_x = std::sin(x);
        const double cos_x = std::cos(x);

        const double c1 = 1;
        const double c2 = 2;

        return c1 * cos_x + c2 * sin_x;
    }


   void task_shooting_method()
    {
        std::cout << "\t Task_2: " << std::endl;

        using Y_arg = Math_Vector<double>;
        const double eps = 0.000001;

        const double x0 = 0.0;             //разные начальные и граничные условия
        const double xn = 10.0;
        const double y0 = exact_func(x0);
        const double yn = exact_func(xn);
        const double h = 0.01;
        const int h_steps_amount = (xn - x0) / h;

        std::ofstream out_put("exact_solution.dat", std::ios::trunc); //просто выводим точное значение, для графика
        std::cout << "Exact solution:" << std::endl;
        for(int i = 1; i < h_steps_amount+1; i++)
        {
            const double x = x0 + i * h;
            const double y = exact_func(x);
            out_put << x << "\t" << y << std::endl;
        }
        out_put.flush();
        out_put.close();
        std::cout << std::endl;

        auto func_dy = [](const double z)  //это функции для нашей системы. Можешь посмотреть как она выглядит в тетради
        {                                   //это вот точь в точь
            return z;                       //конечно наверно можно было прямо в систему писать... но у меня не вышло
        };                                  //чет там накосячил, в итоге - так.

        auto func_dz = [](const double y, const double x)
        {
            return -y;
        };

        auto ode_system = [&func_dy, &func_dz](const Y_arg y, const double x) -> Y_arg
        {
            return {func_dy(y[1]), func_dz(y[0], x)};
        };
        //1.78648
        double first_shoot_param = 100.0;
        shooting_method<Y_arg> sm(ode_system, y0, yn, x0, xn, h, first_shoot_param);

        std::vector<double> vec(50,first_shoot_param);
        int arr = 0;
        while(!sm.check_param())
        {
            sm.next_shoot();
            vec[arr] = sm.get_shoot_param();
            arr++;
        }
        std::ofstream output("shoot_solution.dat", std::ios::trunc);

        int step = 1;
        while(!sm.check_end())
        {
            const double x = x0 + step * h;
            Y_arg y = sm.get_next_step();
            std::cout << "X = " << x << "\tY = " << y << std::endl;
            output << x << "\t" << y << std::endl;
            step++;
        }

        output.flush();
        output.close();
        std::cout << exact_func(xn) << std::endl;
   }

    void run(const int number_task)
    {
        switch(number_task)
        {
            case 1 : {task_ode_system_solution(); } break;
            case 2 : {task_shooting_method(); } break;
            default : {std::cout << "Error! number_task don't seached" << std::endl;}
        }
    }
}

#endif // TASKS_HXX
