//usr/bin/env true && "$(dirname $0)"/node_modules/.bin/ts-node --compiler-options='{"strict":true,"lib":["es2019"]}' $0 ; exit $?

import {readFileSync} from 'fs';

console.log(part1());
console.log(part2());

type Ticket = number[];
type Constraint = { min: number; max: number };
type Rule = {
    name: string;
    constraints: [Constraint, Constraint]
};
type Input = { yourTicket: Ticket, nearbyTickets: Ticket[]; rules: Rule[] };

function readInput(): Input {
    const inputString = readFileSync('day16-input.txt', 'utf8');

    const [ruleSection, yourTicketSection, nearbyTicketSection] = inputString.trim().split(/\n\n.*:\n/);

    const yourTicket: Ticket = yourTicketSection
        .trim()
        .split(',')
        .map(i => parseInt(i));

    const nearbyTickets: Ticket[] = nearbyTicketSection
        .trim()
        .split('\n')
        .map(ticketLine =>
            ticketLine
                .trim()
                .split(',')
                .map(i => parseInt(i)),
        );

    const rules: Rule[] = ruleSection
        .trim()
        .split('\n')
        .map(ruleLine => {
            const [name, constraintsString] = ruleLine.split(': ');
            const [c1, c2] = constraintsString.split(' or ').map(constraintsString => {
                const [min, max] = constraintsString.split('-').map(i => parseInt(i));
                return {min, max};
            });
            return {name, constraints: [c1, c2]};
        });
    return {rules, yourTicket, nearbyTickets};
}

function part1(): number {
    const input = readInput();
    return input.nearbyTickets
        .flatMap(ticket => ticket.filter(n => !ticketNumValidForAtLeastOneRule(n, input)))
        .reduce((a, b) => a + b);
}

function ticketNumValidForAtLeastOneRule(num: number, input: Input): boolean {
    for (const rule of input.rules) {
        if (ticketNumValidForRule(num, rule)) {
            return true;
        }
    }
    return false;
}

function ticketNumValidForRule(num: Number, {constraints: [c1, c2]}: Rule): boolean {
    return (num >= c1.min && num <= c1.max) || (num >= c2.min && num <= c2.max);
}

function ticketValidForAllFields(ticket: Ticket, input: Input): boolean {
    for (let num of ticket) {
        if (!ticketNumValidForAtLeastOneRule(num, input)) {
            return false;
        }
    }
    return true;
}

function part2(): number {
    const input: Input = readInput();
    const validInput: Input = {
        ...input,
        nearbyTickets: input.nearbyTickets.filter((t) => ticketValidForAllFields(t, input)),
    };
    const foundPositions: Set<number> = new Set();
    const positionByRule: Map<Rule, number> = new Map();
    while (foundPositions.size < validInput.yourTicket.length) {
        for (let i = 0; i < validInput.yourTicket.length; i++) {
            if (foundPositions.has(i)) {
                continue;
            }
            const candidates: Rule[] = validInput.rules
                .filter(r => !positionByRule.has(r))
                .filter(r => isRuleValidForAllTickets(r, i, validInput));
            if (candidates.length === 1) {
                positionByRule.set(candidates[0], i);
                foundPositions.add(i);
                break;
            }
        }
    }
    return Array.from(positionByRule.entries())
        .filter(([r, _]) => r.name.startsWith('departure '))
        .map(([_, i]) => validInput.yourTicket[i])
        .reduce((a, b) => a * b);
}

function isRuleValidForAllTickets(rule: Rule, index: number, validInput: Input) {
    for (let ticket of [validInput.yourTicket, ...validInput.nearbyTickets]) {
        if (!ticketNumValidForRule(ticket[index], rule)) {
            return false;
        }
    }
    return true;
}
