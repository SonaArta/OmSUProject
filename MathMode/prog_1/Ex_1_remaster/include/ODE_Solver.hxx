#ifndef ODE_SOLVER_HXX
#define ODE_SOLVER_HXX

#include "library.hxx"
#include "math_vector.hxx"

template <typename U_arg, typename T_arg>
class ODE_Solver
{
    private:
        const U_arg u_start;
        const T_arg t_start;
        
    protected: 
	const int m_order;
        T_arg dt;
        T_arg t;
     	

        const std::function<U_arg(U_arg,T_arg)> func;

        U_arg get_u_start() {return this->u_start;}
        T_arg get_t_start() {return this->t_start;}

    public:
        ODE_Solver() = default;
        ODE_Solver(const std::function<U_arg(U_arg,T_arg)> func,
                    const U_arg& u_start,
                    const T_arg& t_start,
                    const T_arg& dt,
                    const int order) : m_order(order),
                                        u_start(u_start),
                                        t_start(t_start),
                                        t(t_start),
                                        dt(dt),
                                        func(func) {}

        ~ODE_Solver() {}

        virtual U_arg get_Solution() = 0;
        /*void refresh(const int dt) {this->u_prev = this->get_u_start();
                                    this->t = this->get_t_start();}*/


       /* virtual U_arg get_Solution(std::function<U_arg(U_arg,T_arg)> func.
                                    const U_arg& u_start,
                                    const T_arg& t_start,
                                    const T_arg& dt) = 0;*/
};

#endif // ODE_SOLVER_HXX
