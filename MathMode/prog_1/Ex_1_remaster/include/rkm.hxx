#ifndef RKM_HXX
#define RKM_HXX

#include "library.hxx"
#include "math_vector.hxx"
#include "butcher_table.hxx"
#include "ODE_Solver.hxx"

template<typename U_arg,typename T_arg>
class RKM : public ODE_Solver<U_arg, T_arg>
{
    public:
        Butcher_table table;
        U_arg u_prev;
        int counter = 0;
        RKM() = default;
        RKM(const std::function<U_arg(U_arg, T_arg)> func,
                           const U_arg& u_start,
                           const T_arg& t_start,
                           const T_arg& dt,
                           const int order) : ODE_Solver<U_arg, T_arg>(func, u_start, t_start, dt, order), u_prev(u_start) {}
        virtual ~RKM() = default;
        U_arg get_Solution() override;

        virtual Math_Vector<U_arg> get_K() = 0;


};

template<typename U_arg, typename T_arg>
U_arg RKM<U_arg,T_arg>::get_Solution()
{

    Math_Vector<U_arg> K =  this->get_K();
    U_arg sum = this->u_prev;
    if(counter < 1)
    {
        counter++;
        return sum;
    }
    else
    {
        for(size_t i = 0; i < K.size(); i++)
        {
            sum = sum + K[i] * this->table.get_B(i) * this->dt;
        }
        this->u_prev = sum;
        this->t += this->dt;
        return sum;
    }

}

#endif // RKM_HXX
