#include "SymbolicConstant.h"
#include "../../Halide/src/IRVisitor.h"
#include "../../Halide/src/IROperator.h"

namespace Halide {
namespace Internal {

using std::string;

// Check if an expression is constant or not.
class ConstantChecker : public IRVisitor {
    using IRVisitor::visit;

    /*
	bool is_symbolic_constant(const Expr &expr) {
		if (const Variable *c = expr.as<Variable>()) {
			if (c->param.is_symbolic_constant()) {
				return true;
			}
		}
		return false;
	}*/

public:
    // Is the result constant?
    bool is_constant;

    ConstantChecker() : is_constant(true) {}

    void visit(const IntImm *expr) override {
    	if (!Internal::is_const(expr)) {
    		is_constant = false;
    	}
    }

    void visit(const UIntImm *expr) override {
    	if (!Internal::is_const(expr)) {
    		is_constant = false;
    	}
    }

    void visit(const FloatImm *expr) override {
    	if (!Internal::is_const(expr)) {
    		is_constant = false;
    	}
    }

    void visit(const StringImm *expr) override {
    	if (!Internal::is_const(expr)) {
    		is_constant = false;
    	}
    }

    void visit(const Variable *expr) override {
    	if (expr->param.defined() && !expr->param.is_symbolic_constant()) {
    		is_constant = false;
    	}
    }
};

bool can_resolve_as_const(const Expr &e) {
	ConstantChecker checker;
	e.accept(&checker);
	return checker.is_constant;
}

}  // namespace Internal
}  // namespace Halide
