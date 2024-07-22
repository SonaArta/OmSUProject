#ifndef MSM_HXX
#define MSM_HXX

#include "library.hxx"
#include "rkm.hxx"
#include "snae_solver.hxx"
#include "circular_array.hxx"
#include "ODE_Solver.hxx"


template<typename U_arg = double, typename T_arg = double>
class MSM : public ODE_Solver<U_arg, T_arg>
{
    private:
        using RKM = RKM<U_arg,T_arg>;
        using SNAE = Simple_Iteration_Method<U_arg>;
        RKM * rkm;
        SNAE* snae;

        //RKM<U_arg,T_arg>* rkm;
        //Simple_Iteration_Method<U_arg>* snae;
        std::vector<double> Beta;
        Circular_Array<U_arg> all_previous_u;
        int counter = 0;


    public:
        MSM() = default;
        MSM(const std::function<U_arg(U_arg, T_arg)> func,
                           const U_arg& u_start,
                           const T_arg& t_start,
                           const T_arg& dt,
                           const int order) : ODE_Solver<U_arg, T_arg>(func, u_start, t_start, dt, order),
                                               all_previous_u(this->m_order - 1)
        {
           rkm = new RMK_implicit<U_arg, T_arg>(func, u_start, t_start, dt, order);

           snae = new Simple_Iteration_Method<U_arg>;
           switch(order)
           {
               case 2:  Beta = {0.5, 0.5}; break;
               case 3:  Beta = {5.0/12.0, 2.0/3.0, -1.0/12.0};break;
           }
           get_start_u();
        }
        ~MSM()
         {
             delete rkm;
             delete snae;
             snae = nullptr;
             rkm = nullptr;
         }

        U_arg get_sum_multy()
        {
            const int n = this->m_order - 1;
            U_arg sum = Beta[n] *  this->func(all_previous_u[0], this->t);
            for(int i = 1; i < n; i++)
            {
                T_arg curr_t = this->t + i * this->dt;
                sum = sum + Beta[n - i] * this->func(all_previous_u[i],curr_t);
            }
            return sum;
        }

        void get_start_u()
        {
            const int n = this->m_order - 1;
            std::vector<U_arg> all_prev_step_u(n, this->func(this->get_u_start(), this->t));
            for(int i = 0; i < n; i++)
            {
                all_prev_step_u[i] = rkm->get_Solution();
            }
            for(int i = 0; i < n; i++)
            {
                all_previous_u.push(all_prev_step_u[i]);
            }
        }

        U_arg get_last_step()
        {
            const int n = this->m_order - 1;
            U_arg sum_multy = get_sum_multy();
            U_arg u_previous = all_previous_u[n - 1];
            T_arg t_next = this->t + n * this->dt;
            double Beta_null = Beta[0];

            auto f = [&](const U_arg u_next)->U_arg
            {
                return u_previous + this->dt *( Beta_null * this->func(u_next, t_next) + sum_multy);
            };
            Math_Vector<U_arg> u_next (1,u_previous);
            u_next = snae->get_Solution(f, u_next);
            return u_next[0];
        }

        U_arg get_Solution()
        {
             if(counter < this->m_order - 1)
             {
                 return all_previous_u[counter++];
             }
             else
             {
                 const U_arg last_step = get_last_step();
                 all_previous_u.push(last_step);
                 this->t += this->dt;
                 return last_step;
             }
        }

};

#endif // MSM_HXX
