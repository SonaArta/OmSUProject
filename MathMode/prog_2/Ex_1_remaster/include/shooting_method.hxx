#ifndef SHOOTING_METHOD_HXX
#define SHOOTING_METHOD_HXX

#include "all.hxx"
#define epsilon 0.00001


template<typename Y_arg = double,
         typename X_arg = double>
class shooting_method
{
    private:
        std::function<Y_arg(Y_arg, X_arg)> f;

        const X_arg y0;
        const X_arg yn;

        const X_arg x0;
        const X_arg xn;
        const X_arg h;
        const int steps_amount;

        const double eps = 0.00000001;

        double shoot_param;
        double y_shoot_param;

        Y_arg start_condition;
        X_arg x_curr;

        ODE_Solver<Y_arg, X_arg>* msm_solv = nullptr;

    private:
        void shoot();
        void reset_ode_solver();


    public:
        shooting_method() = default;
        shooting_method(std::function<Y_arg(Y_arg, X_arg)> f,
                        const X_arg y0,
                        const X_arg yn,
                        const X_arg x0,
                        const X_arg xn,
                        const X_arg h,
                        double shoot_param) : f(f),
                                              y0(y0),
                                              yn(yn),
                                              xn(xn),
                                              h(h),
                                              x0(x0),
                                              shoot_param(shoot_param),
                                              start_condition{y0, shoot_param},
                                              steps_amount{(xn - x0) / h},
                                              x_curr(x0), msm_solv {new MSM<Y_arg, X_arg>{f, start_condition, x0, h, 3}}
        {

            this->reset_ode_solver();
        }
        ~shooting_method(){delete this->msm_solv;}

        void next_shoot();
        void restart();
        Y_arg get_next_step();
        double get_shoot_param();
        bool check_param();
        bool check_end();
};

template<typename Y_arg, typename X_arg>
void shooting_method<Y_arg, X_arg>::shoot()
{
    MSM<Y_arg, X_arg> msm(this->f,
                                 this->start_condition,
                                 this->x0,
                                 this->h,
                                 3);
    auto df_dy = []()
    {
        return -1.0;
    };

    auto df_du = []()
    {
        return 0.0;
    };

    auto sub_system = [&df_dy, &df_du](Y_arg y, X_arg x) -> Y_arg
    {
        const double res = df_dy() * y[0] + df_du() * y[1];
        return {y[1], res};
    };
    Y_arg start_sub_system = {0.0, 1.0};

    MSM<Y_arg, X_arg> msm_subsystem(sub_system, start_sub_system, this->x0, this->h, 3);
    Y_arg solution = this->start_condition;
    Y_arg sub_system_solution = start_sub_system;

    for(int step = 0; step < this->steps_amount; step++)
    {
        solution = msm.get_Solution();
        ///y = solution[0];
        sub_system_solution = msm_subsystem.get_Solution();
    }
    this->y_shoot_param = solution[0];
    this->shoot_param = shoot_param - (1.0 / sub_system_solution[0]) * (this->y_shoot_param - this->yn);

    this->start_condition[1] = this->shoot_param;
    this->restart();
}

template<typename Y_arg, typename X_arg>
void shooting_method<Y_arg, X_arg>::next_shoot()
{
    this->shoot();
}

template<typename Y_arg, typename X_arg>
void shooting_method<Y_arg, X_arg>::reset_ode_solver()
{
    delete this->msm_solv;
    this->msm_solv = new MSM<Y_arg, X_arg>(this->f, this->start_condition, this->x0, this->h, 3);
}

template<typename Y_arg, typename X_arg>
void shooting_method<Y_arg, X_arg>::restart()
{
    this->reset_ode_solver();
    this->x_curr = this->x0;
}

template<typename Y_arg, typename X_arg>
Y_arg shooting_method<Y_arg, X_arg>::get_next_step()
{
    Y_arg solution = this->msm_solv->get_Solution();
    x_curr += h;
    return solution;
}

template<typename Y_arg, typename X_arg>
double shooting_method<Y_arg, X_arg>::get_shoot_param()
{
    return this->shoot_param;
}

template<typename Y_arg, typename X_arg>
bool shooting_method<Y_arg, X_arg>::check_param()
{
    const bool check = (std::abs(this->yn - this->y_shoot_param) <= this->eps);
    return check;
}

template<typename Y_arg, typename X_arg>
bool shooting_method<Y_arg, X_arg>::check_end()
{
    const double eps_ = 0.00001;
    const double diff = std::abs(xn - x_curr);
    return diff < eps_;
}


#endif // SHOOTING_METHOD_HXX
