#ifndef RMK_IMPLICIT_HXX
#define RMK_IMPLICIT_HXX

#include "library.hxx"
#include "math_vector.hxx"
#include "rkm.hxx"
#include "butcher_table.hxx"
#include "ODE_Solver.hxx"

#define e 0.00001

template<typename U_arg, typename T_arg, int stage = 2> // s >= p
class RMK_implicit : public RKM<U_arg, T_arg>
{
    public:
        RMK_implicit() = default;

        RMK_implicit(const std::function<U_arg(U_arg, T_arg)> func,
                           const U_arg& u_start,
                           const T_arg& t_start,
                           const T_arg& dt,
                           const int order) : RKM<U_arg, T_arg>(func, u_start, t_start, dt, order)
        {
            std::vector<std::vector<double>> coeff_A;
            std::vector<double> coeff_B;
            std::vector<double> coeff_C;
            switch(order)
            {
               case 2:
               {
                    coeff_A = {{0.5, 0.5},
                                {-0.5, 0.5}};
                    coeff_B = {0.5, 0.5};
                    coeff_C = {0.0, 1.0};
                    break;
                }
               case 3:
                {
                    coeff_A = {{1.0/4.0, -1.0/4.0},
                               {1.0/4.0, 5.0/12.0}};
                    coeff_B = {1.0/4.0, 3.0/4.0};
                    coeff_C = {0.0, 2.0/3.0};
                    break;
                }
            }
            this->table = Butcher_table(coeff_A, coeff_B, coeff_C);
        };
        ~RMK_implicit() = default;

    virtual Math_Vector<U_arg> get_K() override;

};

template<typename U_arg, typename T_arg, int stage>
Math_Vector<U_arg> RMK_implicit<U_arg, T_arg, stage>:: get_K()
  {
     U_arg start_value = this->func(this->u_prev, this->t);
     Math_Vector<U_arg> K(stage, start_value);
     Math_Vector<U_arg> temp_K = K;

     double max_diff = 0.0;
     do
     {
         for (int i = 0; i < stage; i++)
         {
             U_arg left_sum = this->u_prev;
             for(int j = 0; j < stage; j++)
             {
                 left_sum = left_sum + this->table.get_A(i,j) * K[j] * this->dt;
             }
             T_arg right_sum = this->t + this->table.get_C(i) * this->dt;
             K[i] = this->func(left_sum, right_sum);
         }

        int size_v = K.size();
        std::vector<double> current(size_v, 0.0);
        std::vector<double> previous(size_v, 0.0);
        for(int i = 0; i < size_v; i++)
        {
           current[i] = Math_Abs(K[i]);
           previous[i] = Math_Abs(temp_K[i]);
        }
        double max_curr = *std::max_element(current.begin(), current.end());
        double max_prev = *std::max_element(previous.begin(), previous.end());
        max_diff = std::fabs(max_prev - max_curr);

        temp_K = K;
     }
     while( max_diff > e);
     return K;
  }
#endif
 // RMK_IMPLICIT_HXX
