#ifndef RKM_EXPLICIT_HXX
#define RKM_EXPLICIT_HXX

#include "library.hxx"
#include "rkm.hxx"
#include "math_vector.hxx"
#include "butcher_table.hxx"
#include "ODE_Solver.hxx"

template<typename U_arg, typename T_arg, int stage = 2>
class RKM_explicit: public RKM<U_arg, T_arg>
{
    public:
        RKM_explicit() = default;
        RKM_explicit(const std::function<U_arg(U_arg, T_arg)> func,
                           const U_arg& u_start,
                           const T_arg& t_start,
                           const T_arg& dt,
                           const int order) : RKM<U_arg, T_arg>(func, u_start, t_start, dt, order)
        {
            /*std::vector<std::vector<double>> A_coeff = {{0.0, 0.0},
                                                        {0.5, 0.0}};
            std::vector<double> B_coeff = {0.0, 1.0};
            std::vector<double> C_coeff = {0.0, 0.5};*/

            std::vector<std::vector<double>> A_coeff = {{0.0, 0.0},
                                                        {2.0/3.0, 0.0}};
            std::vector<double> B_coeff = {0.25, 3.0/4.0};
            std::vector<double> C_coeff = {0.0, 2.0/3.0};

            this->table = Butcher_table(A_coeff, B_coeff, C_coeff);

        };
        ~RKM_explicit() = default;


        virtual Math_Vector<U_arg> get_K() override
        {
            U_arg start_value = this->func(this->u_prev, this->t);
            Math_Vector<U_arg> K(stage, start_value);
            for (int i = 1; i < stage; i++)
            {
                 U_arg left_sum = this->u_prev;
                 T_arg right_sum = this->t;
                 for(int j = 0; j < i; j++)
                 {
                     left_sum = left_sum + this->table.get_A(i,j) * K[j] * this->dt;
                 }
                 right_sum = this->t + this->table.get_C(i) * this->dt;
                 K[i] = this->func(left_sum, right_sum);
            }
            this->t += this->dt;
            return K;
        }
};

#endif // RKM_EXPLICIT_HXX
